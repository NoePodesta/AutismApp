$(document).ready(function() {


    var sentencePackageForm = $("#sentence_package").sheepIt({
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
                id: 'sentence_package_#index#_articles',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_articles#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_sustantivs',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_sustantivs#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_verbs',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_verbs#',
                    maxFormsCount: 4
                }
            },
            {
                id: 'sentence_package_#index#_adjectives',
                options: {
                    separator: '<div style="width:100%; border-top:1px solid #c8cccb; margin: 10px 0px;"></div>',
                    indexFormat: '#index_adjectives#',
                    maxFormsCount: 4
                }
            }
        ]
    });


});
