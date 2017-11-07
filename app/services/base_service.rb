
class BaseService
 include Dry::Monads::Either::Mixin

 def form
  raise StandardError.new("Undefined form")
 end
end