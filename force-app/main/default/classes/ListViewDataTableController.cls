/**
 * Simple proof of concept apex class to retrieve sobject records
 * per a list view filter id and display them in a lightning component.
 *
 * Inspired by Peter Churchill (https://twitter.com/britishboyindc/status/989969757104467969)
 *
 * Developed by Doug Ayers (douglascayers.com)
 */
public class ListViewDataTableController {

    @AuraEnabled
    public static ListViewDataTable getListViewDataById( String namedCredential, ID listViewId ) {

		ListViewDescribeResult result = getListViewDescribe( namedCredential, listViewId );

        ApexPages.StandardSetController controller = new ApexPages.StandardSetController( Database.getQueryLocator( result.query ) );
		//add pagination
        //controller.setPageNumber( 1 );
        //controller.setPageSize( 10 );

        ListViewDataTable dataTable = new ListViewDataTable();
        dataTable.records = controller.getRecords();
        dataTable.describeResult = result;

        return dataTable;
    }

    private static ListViewDescribeResult getListViewDescribe( String namedCredential, ID listViewId ) {

        ListView listView = [ SELECT id, sobjectType FROM ListView WHERE id = :listViewId LIMIT 1 ];

        String endpoint = String.format(
            'callout:{0}/sobjects/{1}/listviews/{2}/describe',
            new String[] { namedCredential, listView.sobjectType, listView.id }
        );

        HttpRequest req = new HttpRequest();
        req.setEndpoint( endpoint );
        req.setMethod( 'GET' );
        req.setTimeout( 120000 ); // max wait of 2 mins
        req.setCompressed( true );
        req.setHeader( 'Content-Type', 'application/json' );
        req.setHeader( 'Accepts', 'application/json' );

        HttpResponse res = new Http().send( req );
        System.debug( res );
        System.debug( res.getBody() );

		ListViewDescribeResult result = (ListViewDescribeResult) JSON.deserialize( res.getBody(), ListViewDescribeResult.class );

		return result;
    }

    public class ListViewDataTable {

        @AuraEnabled
        public List<SObject> records { get; set; }

        @AuraEnabled
        public ListViewDescribeResult describeResult { get; set; }

    }

    public class ListViewDescribeResult {

        @AuraEnabled
        public ID id { get; set; }

        @AuraEnabled
        public String query { get; set; }

        @AuraEnabled
        public String sobjectType { get; set; }

        @AuraEnabled
        public List<Map<String, String>> columns { get; set; }

    }

}