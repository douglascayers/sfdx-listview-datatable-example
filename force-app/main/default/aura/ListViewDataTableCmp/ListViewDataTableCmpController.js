({
    init : function( component, event, helper ) {

        var listViewId = component.get( 'v.listViewId' );

        if ( $A.util.isUndefinedOrNull( listViewId ) ) {
            return;
        }

        helper.enqueueAction( component, 'c.getListViewDataById', {

            'namedCredential' : component.get( 'v.namedCredential' ),
            'listViewId' : component.get( 'v.listViewId' )

        }).then( $A.getCallback( function( result ) {

            console.log( result );

            // remove any hidden columns then transform the format for lightning:datatable
            var displayColumns = result.describeResult.columns.filter( function( column ) { return column.hidden === 'false'; } ).map( function( column ) {
                return {
                    'label' : column.label,
                    'fieldName' : column.fieldNameOrPath ,
                    'type' : column.type
                };
            });

            component.set( 'v.mydata', result.records );
            component.set( 'v.mycolumns', displayColumns );

        })).catch( $A.getCallback( function( error ) {

            console.error( error );
            component.find( 'notifLib' ).showNotice({
                'variant' : 'error',
                'header' : 'Sorry to interrupt',
                'message' : error
            });

        }));

    }
})