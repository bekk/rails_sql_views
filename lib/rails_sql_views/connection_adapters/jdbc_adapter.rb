module ActiveRecord
  module ConnectionAdapters
    class JdbcAdapter
      def supports_views?
        true
      end
      
      def nonview_tables(name = nil)
        tables
      end

      def views(name = nil)
        select_values(delegate.list_views_statement, name)
      end
      
      private
      
      def delegate
        return @delegate if @delegate
        if ActiveRecord::Base.configurations[Rails.env]["driver"] =~ /jtds/
          @delegate = SQLServerAdapter.new(nil, nil)
        else
          raise "Views only implemented for MSSQL. Implement for other adapters. PLEASE!"
        end
      end
    end
  end
end
