$(document).ready(function() {


    var sentencePackageForm = $("#sentence_package").sheepIt({
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
                id: 'sentence_package_#index#_articles',
                options: {
                    indexFormat: '#index_articles#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_sustantivs',
                options: {
                    indexFormat: '#index_sustantivs#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_verbs',
                options: {
                    indexFormat: '#index_verbs#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_adjectives',
                options: {
                    indexFormat: '#index_adjectives#',
                    maxFormsCount: 4
                }
            }
        ]
    });


});
