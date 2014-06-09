# From my_database/monitoring.rb

    # First we have to make sure we're connecting to the Zabbix API
    connect_to_zabbix_api!

    # Now we can create a host to represent the new database
    zabbix_host "my-database" do
      host_groups ["Foo_Databases"]
      templates   ["Foo_Database_Template"]
      virtual     true # this is not a *real* machine, just a Zabbix host
      action      :create
    end

    # And an item for the host
    zabbix_item "Performance of Foo database connection" do
      host 'my-database'
      key  'tcp_perf,8080'
      value_type :float
      units 's'

      # 'simple' means the Zabbix server executes these checks, as
      #  appropriate for a remote port check
      type :simple

      action :create
    end

    # And now a trigger on the item
    zabbix_trigger "Response time too high on Foo database connection" do
      host 'my-database'
      priority :warning

      # Fire if the item 'tcp_perf,8080' on the host 'my-database' has an
      # 'avg' value over the last '300' seconds that is greater than '2'
      # -- i.e., fire if the average response connection time of the Foo
      # database's portspikes to 2 seconds anytime over the last 5
      # minutes.
      expression "{my-database:tcp_perf,8080.avg(300)>2}"

      action   :create
    end
