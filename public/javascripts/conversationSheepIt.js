$(document).ready(function() {


    var sentencePackageForm = $("#conversation_package").sheepIt({
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
                id: 'conversation_package_#index#_answers',
                options: {
                    indexFormat: '#index_answers#',
                    maxFormsCount: 4
                }
            }
        ]
    });


});
