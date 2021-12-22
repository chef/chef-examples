describe port(443) do
  it { should be_listening }
end

describe http('https:/localhost/', ssl_verify: false) do
  its('status') { should cmp 200 }
  its('body') { should match /Hello, world!/ }
end

describe package('apache2') do
  its('version') { should match /2.4.41/ }
end

describe ssl(port: 443).protocols('ssl3') do
  it { should_not be_enabled }
end

describe ssl(port: 443).protocols('tls1.2') do
  it { should be_enabled }
end
