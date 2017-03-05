require File.expand_path(File.dirname(__FILE__) + '/neo')

# Project: Create a Proxy Class
#
# In this assignment, create a proxy class (one is started for you
# below).  You should be able to initialize the proxy object with any
# object.  Any messages sent to the proxy object should be forwarded
# to the target object.  As each message is sent, the proxy should
# record the name of the method sent.
#
# The proxy class is started for you.  You will need to add a method
# missing handler and any other supporting methods.  The specification
# of the Proxy class is given in the AboutProxyObjectProject koan.

class Proxy

     attr_reader :messages
# Esto es necesario para crear el método para leer la variable de instancia.
#Si no lo hacemos no podra leer los :objeto dentro de la [] de @messages.
  def initialize(target_object)
    @object = target_object       
    @messages = [] 
    #Esto inizializa el objeto proxy con cualquier objeto
    #También dice que los mensajes enviados se guarden  ya que
    #en la 69 nos los va a pedir
    # ADD MORE CODE HERE
  end
 
  def method_missing(name_of_method, *channels)
   #Variables el metodo y el canal. 
   # Canal tiene el asterisco que indica que el número de argumentos 
   # puede ser el que se quiera y los va a tratar como array. 
    if @object.respond_to?(name_of_method)
       return @messages.push(name_of_method) && @object.send(name_of_method, *channels)
   #Si el objeto responde, conseguimos dos cosas:
   # 1.- pasar el test: test_proxy_records_messages_sent_to_tv
   #ya que metemos el nombre del método dentro del array mensajes (el cual hemos definido en el initialize)
   #2.- devuelve el metodo (con el que ha respondido) y channels (con esto pasamos el test   de tv.channel = 10) 
    else  
      
    super name_of_method, Exception
  #Esto pasa el test_proxy_handles_invalid_messages (si ponemos return no lo pasa)
  #Ponemos super para poder  llamar a los métodos en la superclase o en todas las clases
  # pasa a todos los argumento sal metodo de la clase principal

    end
  end
 
#Tenemos que crear dos métodos:
# called? porque nos lo pide en el test test_proxy_reports_methods_have_been_called
# number_of_times_called porque nos lo pide en el test test_proxy_counts_method_calls
  def called?(name_of_method)
    if @messages.include?(name_of_method)
      return true
    end
  end
  #Le pregunta a @mensajes si incluye el método
  # devuelve un true o un false
  
  def number_of_times_called(name_of_method)
    @messages.count(name_of_method)
  end
  #Esto pasa el test_proxy_counts_method_calls porque
  #cuenta el numero de veces que sale el método y nos lo devuelve
  

end

class AboutProxyObjectProject < Neo::Koan
  def test_proxy_method_returns_wrapped_object
    # NOTE: The Television class is defined below
    tv = Proxy.new(Television.new)

    # HINT: Proxy class is defined above, may need tweaking...

    assert tv.instance_of?(Proxy)
  end

  def test_tv_methods_still_perform_their_function
    tv = Proxy.new(Television.new)

    tv.channel = 10
    tv.power

    assert_equal 10, tv.channel
    assert tv.on?
  end

  def test_proxy_records_messages_sent_to_tv
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel = 10

    assert_equal [:power, :channel=], tv.messages
  end

  def test_proxy_handles_invalid_messages
    tv = Proxy.new(Television.new)

    assert_raise(NoMethodError) do
      tv.no_such_method
    end
  end

  def test_proxy_reports_methods_have_been_called
    tv = Proxy.new(Television.new)

    tv.power
    tv.power

    assert tv.called?(:power)
    assert ! tv.called?(:channel)
  end

  def test_proxy_counts_method_calls
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel = 48
    tv.power

    assert_equal 2, tv.number_of_times_called(:power)
    assert_equal 1, tv.number_of_times_called(:channel=)
    assert_equal 0, tv.number_of_times_called(:on?)
  end

  def test_proxy_can_record_more_than_just_tv_objects
    proxy = Proxy.new("Code Mash 2009")

    proxy.upcase!
    result = proxy.split

    assert_equal ["CODE", "MASH", "2009"], result
    assert_equal [:upcase!, :split], proxy.messages
  end
end


# ====================================================================
# The following code is to support the testing of the Proxy class.  No
# changes should be necessary to anything below this comment.

# Example class using in the proxy testing above.
class Television
  attr_accessor :channel

  def power
    if @power == :on
      @power = :off
    else
      @power = :on
    end
  end

  def on?
    @power == :on
  end
end

# Tests for the Television class.  All of theses tests should pass.
class TelevisionTest < Neo::Koan
  def test_it_turns_on
    tv = Television.new

    tv.power
    assert tv.on?
  end

  def test_it_also_turns_off
    tv = Television.new

    tv.power
    tv.power

    assert ! tv.on?
  end

  def test_edge_case_on_off
    tv = Television.new

    tv.power
    tv.power
    tv.power

    assert tv.on?

    tv.power

    assert ! tv.on?
  end

  def test_can_set_the_channel
    tv = Television.new

    tv.channel = 11
    assert_equal 11, tv.channel
  end
end
