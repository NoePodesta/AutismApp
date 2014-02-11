$(document).ready(function() {


    var sentencePackageForm = $("#class_package").sheepIt({
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
                id: 'class_package_#index#_labels',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_labels#',
                    iniFormsCount: 2
                }
            },
            {
                id: 'class_package_#index#_images',

                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_images#',
                    maxFormsCount: 8,
                    minFormsCount: 2

                }
            }
        ]
    });


});
