require "spec_helper"

describe AdaptivePayments::CancelPreapprovalResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"
end
