$(document).ready(function() {


    var sococoPackageForm = $("#sococo_package").sheepIt({
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
                id: 'sococo_package_#index#_labels',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_labels#',
                    minFormsCount: 3,
                    iniFormsCount: 3
                }
            },
            {
                id: 'sococo_package_#index#_secondClassification',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_secondClassification#',
                    minFormsCount: 3,
                    iniFormsCount: 3
                }
            },
            {
                id: 'sococo_package_#index#_questions',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_questions#',
                    minFormsCount: 2,
                    iniFormsCount: 2
                }
            },

            {
                id: 'sococo_package_#index#_images',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_images#',
                    maxFormsCount: 8
                }
            }
        ]
    });


});
