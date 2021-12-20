describe port(80) do
  it { should be_listening }
end

describe http('http:/localhost/') do
  its('status') { should cmp 200 }
  its('body') { should match /Hello, world!/ }
end

describe package('apache2') do
  its('version') { should match /2.4.41/ }
end
