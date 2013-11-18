$(document).ready(function() {


    var sentencePackageForm = $("#sococo_package").sheepIt({
        separator: '',
        allowRemoveLast: true,
        allowRemoveCurrent: true,
        allowRemoveAll: true,
        allowAdd: true,
        allowAddN: false,

        // Limits
        maxFormsCount: 3,
        minFormsCount: 0,
        iniFormsCount: 1,

        continuousIndex: true

    });


});
