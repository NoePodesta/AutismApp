$(document).ready(function() {


    var sentencePackageForm = $("#class_package").sheepIt({
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
                id: 'class_package_#index#_labels',
                options: {
                    indexFormat: '#index_labels#',
                    maxFormsCount: 2
                }
            },
            {
                id: 'class_package_#index#_images',
                options: {
                    indexFormat: '#index_images#',
                    maxFormsCount: 8
                }
            }
        ]
    });


});
