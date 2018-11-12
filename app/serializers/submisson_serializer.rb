# frozen_string_literal: true

class SubmissionSerializer
  include FastJsonapi::ObjectSerializer
  set_id :friendly_id
  attributes :author, :shortend_body, :sub_path, :vote_path
  attribute :voted_on do |object, params|
    params[:current_user].voted_on?(object)
  end
end
