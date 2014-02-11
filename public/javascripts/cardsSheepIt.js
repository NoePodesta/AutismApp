$(document).ready(function() {


    var sentencePackageForm = $("#cards").sheepIt({
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

        continuousIndex: true

    });


});
