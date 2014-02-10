$(document).ready(function() {


    var sococoPackageForm = $("#sococo_package").sheepIt({
        separator: '',
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
                    indexFormat: '#index_labels#',
                    minFormsCount: 3,
                    iniFormsCount: 3
                }
            },
            {
                id: 'sococo_package_#index#_secondClassification',
                options: {
                    indexFormat: '#index_secondClassification#',
                    minFormsCount: 3,
                    iniFormsCount: 3
                }
            },
            {
                id: 'sococo_package_#index#_questions',
                options: {
                    indexFormat: '#index_questions#',
                    minFormsCount: 3,
                    iniFormsCount: 3
                }
            },

            {
                id: 'sococo_package_#index#_images',
                options: {
                    indexFormat: '#index_images#',
                    maxFormsCount: 8
                }
            }
        ]
    });


});
