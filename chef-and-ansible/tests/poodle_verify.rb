describe ssl(port: 443).protocols('ssl3') do
  it { should_not be_enabled }
end

describe ssl(port: 443).protocols('tls1.2') do
  it { should be_enabled }
end
