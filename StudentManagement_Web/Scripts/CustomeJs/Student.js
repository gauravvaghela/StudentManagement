var tblStudent;
const monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];

function fnBindStudentCourse() {
    $.ajax({
        url: '/Student/BindStudentCourseList',
        dataType: "json",
        type: "POST",
        data: {},
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var ddlCourse = $("#idCourse");
            if (data != null && data != undefined) {
                ddlCourse.empty();
                $.each(data.CourseList, function () {
                    ddlCourse.append($("<option></option>").val(this['CourseId']).html(this['Course']));
                });
            }
            if (data == "-1") {
                console.log("Something is wrong while loading data.");
            }
        },
        error: function (data) {
            console.log("Something is wrong while loading data.");
        },
        failure: function (data) {
            console.log("Something is wrong while loading data.");
        }
    });
}

$("#idOpenStudent").click(function () {
    fnRemoveFormValidation();
    fnClearFormValue();
    $("#formStudent").modal("show");
});

function fnRemoveFormValidation() {
    $("#spanAgeError").css("display", "none");
    $('#idName').removeClass("hasError");
    $('#idDOB').removeClass("hasError");
    $("#idGender").removeClass("hasError");
    $(".ms-choice").removeAttr('style');
    $(".ms-choice").css("border", "1px solid #aaa;");
}

function fnAgeCalculation() {
    var strDOB = $('#idDOB').val();
    if (strDOB != undefined || strDOB != null || strDOB.trim() != "") {
        var today = new Date();
        var birthDate = new Date(strDOB);
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        return age;
    }
}

function fnClearFormValue() {
    $("#idStudent").val(0);
    $("#idName").val("");
    $("#idDOB").val("");;
    $("#idGender").val("0");
    $("#idCourse").multipleSelect("refresh");
    $("#idCourse").multipleSelect("checkAll");
}

function studentFormValidation() {
    var isValid = true;
    var strName = $('#idName').val();
    var strDOB = $('#idDOB').val();
    var stGender = $("#idGender option:selected").val();
    var strCourseIDS = $.map($("#idCourse option:selected"), function (el, i) {
        return $(el).val() == "multiselect-all" ? 0 : $(el).val();
    }).join(',');

    if (strName == undefined || strName == null || strName.trim() == "") {
        $('#idName').addClass("hasError");
        isValid = false;
    }

    if (strDOB == undefined || strDOB == null || strDOB.trim() == "") {
        $('#idDOB').addClass("hasError");
        isValid = false;
    } else {
        var age = fnAgeCalculation();
        if (parseInt(age) < 8) {
            $("#spanAgeError").css("display", "block");
            isValid = false;
        }
    }

    if (stGender == undefined || stGender == null || stGender == "0") {
        $('#idGender').addClass("hasError");
        isValid = false;
    }

    if (strCourseIDS == undefined || strCourseIDS == null || strCourseIDS.trim() == "") {
        $(".ms-choice").css("border", "red 1px solid");
        isValid = false;
    }
    return isValid;
}

function removeValidationOnChangeddl(event) {
    var control = event;
    if ($(control).val() != undefined && $(control).val() != null && $(control).val() != "" && $(control).val() != "0") {
        $(control).removeClass("hasError");
    }
    else {
        $(control).addClass("hasError");
    }
}

function removeValidationOnChange(event) {
    $("#spanAgeError").css("display", "none");
    var control = event;
    if ($(control).val().length > 0) {
        $(control).removeClass("hasError");
    }
    else {
        $(control).addClass("hasError");
    }
}

function removeValidationOnChangeddlForMultiple(event) {
    var control = event;
    if ($(control).val() != undefined && $(control).val() != null && $(control).val() != "" && $(control).val() != "0" && $(control).val() != []) {
        $(".ms-choice").removeAttr('style');
        $(".ms-choice").css("border", "1px solid #aaa;");
    }
    else {
        $(".ms-choice").removeAttr('style');
        $(".ms-choice").css("border", "1px solid red");
    }
}

function fnSaveStudent() {
    var objStudentModel = new Object();

    var CourseIDS = $.map($("#idCourse option:selected"), function (el, i) {
        return $(el).val() == "multiselect-all" ? 0 : $(el).val();
    }).join(',');

    objStudentModel["StudentId"] = $("#idStudent").val().trim();
    objStudentModel["Name"] = $("#idName").val().trim();
    objStudentModel["DateOfBirth"] = $("#idDOB").val();
    objStudentModel["Gender"] = $("#idGender option:selected").val();
    objStudentModel["CourseIDS"] = CourseIDS;

    var isFormValid = studentFormValidation();

    var data = JSON.stringify({ 'objStudentModel': objStudentModel });

    if (isFormValid) {
        $.ajax({
            url: '/Student/SaveStudent',
            dataType: "json",
            type: "POST",
            data: data,
            async: true,
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data > 0) {
                    $("#formStudent").modal('hide');
                    fnGetStudentList();
                }
                if (data == "-1") {
                    console.log("Something is wrong while loading data.");
                }
            },
            error: function (data) {
                console.log("Something is wrong while loading data.");
            },
            failure: function (data) {
                console.log("Something is wrong while loading data.");
            }
        });
    }
}

function fnGetStudentList() {
    $.ajax({
        url: '/Student/GetStudentList',
        dataType: "json",
        type: "POST",
        data: {},
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data != undefined && data != null) {
                if ($.fn.dataTable.isDataTable("#tblStudent")) { $("#tblStudent").DataTable().destroy(); }
                tblStudent = $("#tblStudent").DataTable({
                    "serverSide": false,
                    "filter": true,
                    "stateSave": true,
                    "bSearchable": true,
                    "lengthMenu": [[7, 14, 28, -1], [7, 14, 28, "All"]],
                    "pageLength": 7,
                    "language": {
                        "loadingRecords": "",
                        "processing": "",
                        "emptyTable": "No records available"

                    },
                    "data": data.data,
                    "columns": [
                        { "data": "Name" },
                        { "data": "DateOfBirth" },
                        { "data": "Age", "width": "200px" },
                        { "data": "Gender" },
                        { "data": "", "width": "200px" }
                    ],
                    "aoColumnDefs": [
                        {
                            "targets": [1],
                            "visible": true,
                            "searchable": false,
                            "render": function (data, type, full, meta) {
                                if (full.DateOfBirth != null && full.DateOfBirth != "" && full.DateOfBirth != undefined) {
                                    var DateOfBirthDay = full.DateOfBirth.split('/')[0];
                                    var DateOfBirthMonth = full.DateOfBirth.split('/')[1];
                                    var DateOfBirthYear = full.DateOfBirth.split('/')[2];
                                    return DateOfBirthDay + "-" + monthNames[parseInt(DateOfBirthMonth)-1] + "-" + DateOfBirthYear;
                                } else {
                                    return "";
                                }                                
                            }
                        },
                        {
                            "targets": [2],
                            "visible": true,
                            "searchable": false,
                            "render": function (data, type, full, meta) {
                                if (parseInt(full.Age) <= 10) {
                                    return '<span style="color:red;">' + full.Age + '</span>';
                                }
                                else {
                                    return full.Age;
                                }
                            }
                        },
                        {
                            "targets": [4],
                            "visible": true,
                            "searchable": false,
                            "render": function (data, type, full, meta) {
                                return '<a style="cursor:pointer" class="btn btn-primary" title="Edit Student" onClick="return fnUpdateStudent(' + full.StudentId + ')">Edit</a>'
                                    + '<a style="cursor:pointer;margin-left: 10px" class="btn btn-danger" title="Remove Student" onClick="return fnDeleteStudent(' + full.StudentId + ')">Remove</a>';
                            }
                        }
                    ]
                });
            }
            if (data == "-1") {
                console.log("Something is wrong while loading data.");
            }
        },
        error: function (data) {
            console.log("Something is wrong while loading data.");
        },
        failure: function (data) {
            console.log("Something is wrong while loading data.");
        }
    });
}

function fnUpdateStudent(StudentId) {
    $.ajax({
        url: '/Student/UpdateStudent',
        dataType: "json",
        type: "POST",
        data: JSON.stringify({ "StudentId": StudentId }),
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data != undefined && data != null && data != "") {
                fnBindStudentCourse();
                $("#idStudent").val(data.StudentId);
                $("#idName").val(data.Name);
                if (data.DateOfBirth != null && data.DateOfBirth != "") {
                    var tempDOB = new Date(data.DateOfBirth);
                    var day = ("0" + tempDOB.getDate()).slice(-2);
                    var month = ("0" + (tempDOB.getMonth() + 1)).slice(-2);
                    var DOB = tempDOB.getFullYear() + "-" + (month) + "-" + (day);
                    $("#idDOB").val(DOB);
                } else {
                    $("#idDOB").val("");
                }
                $("#idGender option[value = " + data.Gender + "]").attr("selected", "selected");
                $("#idCourse").multipleSelect("refresh");
                $("#idCourse").multipleSelect("setSelects", data.CourseIDS);
                $("#formStudent").modal('show');
            }
            if (data == "-1") {
                console.log("Something is wrong while loading data.");
            }
        },
        error: function (data) {
            console.log("Something is wrong while loading data.");
        },
        failure: function (data) {
            console.log("Something is wrong while loading data.");
        }
    });
}

function fnDeleteStudent(StudentId) {
    if (confirm("Are you sure you want to delete this record?")) {
        $.ajax({
            url: '/Student/DeleteStudent',
            dataType: "json",
            type: "POST",
            data: JSON.stringify({ "StudentId": StudentId }),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data > 0) {
                    fnGetStudentList();
                    alert("Record deleted successfully.");
                    $("#formStudent").modal('hide');
                }
                if (data == "-1") {
                    console.log("Something is wrong while loading data.");
                }
            },
            error: function (data) {
                console.log("Something is wrong while loading data.");
            },
            failure: function (data) {
                console.log("Something is wrong while loading data.");
            }
        });
    }
}