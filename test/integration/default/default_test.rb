# # encoding: utf-8

# Inspec test for recipe mongo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
#
# And InSpec tests for the following:
# MongoDB is running
# MongoDB is enabled

describe service("mongod") do
  it {should be_running}
  it {should be_enabled}
end

describe package 'mongodb-org' do
  it { should be_installed }
  its('version') { should match /3\./ }
end
#it is basically the provision.sh file
#
# MongoDB is listening on 27017 by default
describe port("0.0.0.0", 27017) do
  it { should be_listening }
end
# MongoDB is listening on 0.0.0.0 by default
