# The +state_machine+ gem is really cool, but I kind of wish
# each of the defined states would make a scope. So if you
# had for instance :queued and :finished as states, you would
# be able to do
#
#    Model.queued     # => Model.where(state: 'queued')
#
# This module makes that happen by putting an after filter
# on the +state_machine+ class method that adds all the scopes.
module ScopeMachine
  def self.included(base)
    class << base

      def state_machine_with_scopes *args, &block
        state_machine_without_scopes(*args, &block).tap do |machine|
          machine.states.map(&:value).each do |state|
            next if respond_to? state
            scope state, where(state: state)
          end
        end
      end

      alias_method_chain :state_machine, :scopes

    end
  end
end
