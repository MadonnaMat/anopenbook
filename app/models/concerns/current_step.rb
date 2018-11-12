# frozen_string_literal: true

module CurrentStep
  extend ActiveSupport::Concern

  included do
    def current_step
      step = self[:current_step]
      self.class.current_steps.invert[step].try(:to_sym) ||
        begin
        if step
          step -= 8
          case step % 2
          when 0
            :"chapter_#{step / 2 + 1}_submission"
          else
            :"chapter_#{step / 2 + 1}_voting"
          end
        end
      end
    end

    def current_step=(step)
      unless step.is_a?(Integer) || step.is_a?(String) || step.is_a?(Symbol)
        raise 'Step must be a string, symbol, or int'
      end
      new_step = self.class.new_step(step)
      super(new_step)
      current_step
    end
  end

  class_methods do
    def current_steps
      @_current_steps = %i[synopsis_submission synopsis_voting
                           cover_art_submission cover_art_voting
                           title_submission title_voting null complete].each_with_index.each_with_object({}) do |(v, i), hsh|
        hsh[v] = i
      end.with_indifferent_access
    end

    def get_current_step(step)
      unless step.is_a?(Integer) || step.is_a?(String) || step.is_a?(Symbol)
        raise 'Step must be a string, symbol, or int'
      end
      new_step(step)
    end

    def new_step(step)
      current_steps[step] ||
        if step.is_a?(Integer)
          step
        else
          c, c_num, c_step = step.to_s.split('_')
          unless c == 'chapter' && c_num && c_step && c_num = c_num.to_i
            raise 'Invalid Key'
          end
          c_num = (c_num - 1) * 2 + 8
          c_num += 1 unless c_step == 'submission'
          c_num
        end
    end
  end
end
