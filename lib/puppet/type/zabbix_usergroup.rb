# frozen_string_literal: true

Puppet::Type.newtype(:zabbix_usergroup) do
  @doc = %q('Manage zabbix usergroups

      zabbix_usergroup{"group1":
        ensure       => present,
        gui_access   => 2,
        debug_mode   => true,
        users_status => true,
      }')

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, namevar: true) do
    desc 'usergroup name'
  end

  newproperty(:gui_access, int: 1) do
    newvalues(0, 1, 2, 3)

    desc 'The type of access for this group. 0 = system default, 1 = internal, 2 = LDAP, 3 = no access'
  end

  newproperty(:debug_mode, boolean: true) do
    desc 'Whether debug mode is enabled or disabled.'

    newvalues(true, false)

    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:users_status, boolean: true) do
    desc 'Whether the user group is enabled or disabled.'

    newvalues(true, false)

    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  autorequire(:file) { '/etc/zabbix/api.conf' }
end
