class ClearanceMailer < ActionMailer::Base
  include Clearance::App::Models::ClearanceMailer
  include Clearance::App::Models::ClearanceFacebookMailer
end
