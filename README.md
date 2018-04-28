# List View Data Table Example

Demonstrates how to use [List View Describe](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/resources_listviewdescribe.htm) information
to query for sobject records and display them in a
Lightning Component using [lightning:datatable](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/aura_compref_lightning_datatable.htm).

The [UI-API](https://developer.salesforce.com/docs/atlas.en-us.uiapi.meta/uiapi/ui_api_resources_list_views_records.htm) also
has ability to retrieve Records and some List View Metadata, but it does not return the
data type of each field to know if a field is text, phone, number, etc. which is important
when specifying the columns of the `<lightning:datatable>` component.


# Getting Started

1. Clone this repository

```
git clone https://github.com/DouglasCAyers/sfdx-listview-datatable-example.git
cd sfdx-listview-datatable-example
```

2. Use Salesforce DX CLI to create a scratch org and push the source to it

```
sfdx force:org:create -f config/project-scratch-def.json -a lvdt -s
sfdx force:source:push -w 10
sfdx force:org:open
```

3. Generate a password for the scratch org, you will need your org's `username` and `password` in the next step.

```
sfdx force:user:password:generate
```

4. Follow [these instructions](https://github.com/DouglasCAyers/sfdx-mass-action-scheduler/wiki/Pre-Requisites-Instructions) to create
   the necessary **Connected App**, **Auth. Provider**, and **Named Credential** to [allow Apex used by a Lightning Component](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/apex_api_calls.htm) to invoke Salesforce REST API.

5. Create some test records for an object and create a list view for them. Note the list view filter id in the browser's address bar (e.g. `00Bxxxxxxxxxxxx`)

6. Use App Builder to add the custom component `ListViewDataTable` to a Lightning Page (e.g. a Home Page or Record Page). Specify the `List View ID` design attribute in App Builder.


# Inpsiration

Inspired by [Peter Churchill](https://twitter.com/britishboyindc/status/989969757104467969) who asked via #askforce on Twitter:
> In Classic, I can use getListViewOptions with a Standard Set Controller to display list views in a dropdown, and then get the records for that list using SetFilterId. Is there any equivalent in LEX components, or an alternative that achieves same result?


# Disclaimer

This project serves as a quick proof-of-concept and as-such does
not provide any unit tests. It is for educational purposes.