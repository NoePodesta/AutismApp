$(document).ready(function() {


    var sentencePackageForm = $("#qa_package").sheepIt({
        separator: '<div style="width:100%; border-top:1px solid #0088cc; margin: 10px 0px;"></div>',
        allowRemoveLast: true,
        allowRemoveCurrent: true,
        allowRemoveAll: true,
        allowAdd: true,
        allowAddN: false,

        // Limits
        maxFormsCount: 10,
        minFormsCount: 0,
        iniFormsCount: 1,

        continuousIndex: true,
        nestedForms: [
            {
                id: 'qa_package_#index#_options',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_options#',
                    maxFormsCount: 4
                }
            }
        ]
    });


});
