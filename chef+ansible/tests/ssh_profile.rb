control "Ensure_SSH_root_login_is_disabled" do
  title "Ensure SSH root login is disabled"
  desc  "
    The PermitRootLogin parameter specifies if the root user can log in using
    ssh. The default is no.
    
    Rationale: Disallowing root logins over SSH requires system admins to 
    authenticate using their own individual account, then escalating to root 
    via sudo or su. This in turn limits opportunity for non-repudiation and 
    provides a clear audit trail in the event of a security incident
  "
  tag group: 'SRG-OS-000112'
  tag vulid: 'V-38607' 
  tag ruleid: 'SV-50408r1_rule' 
  tag severity: 'CAT I' 
  tag stigid: 'RHEL-08-000227' 
  tag cci: 'CCI-000774' 
  tag fixtext: 'PermitRootLogin should not be permitted. The default setting
      in "/etc/ssh/sshd_config" is correct, and can be verified by ensuring
      that the following line appears: PermitRootLogin no'
  impact 1.0
  describe.one do
    describe sshd_config("/etc/ssh/sshd_config") do
      its("PermitRootLogin") { should_not eq('yes') }
    end
    describe package("openssh-server") do
      it { should_not be_installed }
    end
  end 
end
