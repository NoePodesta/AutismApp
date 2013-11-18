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
                id: 'class_package_#index#_options',
                options: {
                    indexFormat: '#index_options#',
                    maxFormsCount: 2
                }
            }
        ]
    });


});
