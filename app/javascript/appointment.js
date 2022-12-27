$(function (){
  function check(){
    $.ajax({
      url: "/check",
      type: "GET",
      dataType: "json",
      data: {
        physician_id: $("#appointment_physician_id").val(),
        date: $("#appointment_schedule_day").val(),
      },
      success: function(result){
        console.log(result);
        $("#appointment_schedule_time option").prop("disabled", false);
        $("#appointment_schedule_time option").each(function(i, v){
          $.each(result, function(ii, vv){
            if(v.value == vv){
              $(v).prop('disabled', true);
            }
          })
        })
      },
      error: function(result){
        alert("Something happened " + result);
      }
    })
  }

  $("#appointment_service_id").on("change", function(){
    if(this.value != ""){
      var service_id = this.value;
      $("#div-service").empty();

      $.ajax({
        url: "/services/" + service_id,
        type: "GET",
        dataType: "json",
        data: {
          service_id: service_id
        },
        success: function(response){
          var service = '<div class="col-md"> \
                          <dl class="row mt-2"> \
                            <dt class="col-sm-3">Name</dt> \
                            <dd class="col-sm-9">' + response.name + '</dd> \
                            <dt class="col-sm-3">Price</dt> \
                            <dd class="col-sm-9">' + response.price.toLocaleString('it-IT', {style : 'currency', currency : 'VND'}); + '</dd> \
                          </dl> \
                        </div>';
          $("#div-service").append(service);
        },
        error: function(response){
          alert("Something happened " + response);
        }
      })

      $("#div-service").show();
    }
    else {
      $("#div-service").hide();
    }
  })

  $("#appointment_patient_id").on("change", function(){
    if(this.value != ""){
      var patient_id = this.value;

      $.ajax({
        url: "/patients/" + patient_id,
        type: "GET",
        dataType: "json",
        data: {
          patient_id: patient_id,
        },
        success: function(res){
          $("#div-patient").empty();

          var patient = '<div class="col-md"> \
                          <dl class="row mt-2"> \
                            <dt class="col-sm-3">Name</dt> \
                            <dd class="col-sm-9">' + res.user.name + '</dd> \
                            <dt class="col-sm-3">Phone</dt> \
                            <dd class="col-sm-9">' + (res.user.phone ? res.user.phone : 'N/A') + '</dd> \
                            <dt class="col-sm-3">Email</dt> \
                            <dd class="col-sm-9">' + res.user.email + '</dd> \
                          </dl> \
                        </div>';
          $("#div-patient").append(patient);
        },
        error: function(res){
          alert("Something happened " + res)
        }
      })

      $("#div-patient").show();
    }
    else {
      $("#div-patient").hide();
    }
  });

  $("#appointment_physician_id").on("change", function(){
    if(this.value != ""){
      var physician_id = this.value;

      $.ajax({
        url: "/physicians/" + physician_id,
        type: "GET",
        dataType: "json",
        data: {
          physician_id: physician_id,
        },
        success: function(res){
          $("#div-physician").empty();
          var physician = '<div class="col-md"> \
                            <dl class="row mt-2"> \
                              <dt class="col-sm-3">Name</dt> \
                              <dd class="col-sm-9">' + res.user.name + '</dd> \
                              <dt class="col-sm-3">Email</dt> \
                              <dd class="col-sm-9">' + res.user.email + '</dd> \
                              <dt class="col-sm-3">Phone</dt> \
                              <dd class="col-sm-9">' + (res.user.phone ? res.user.phone : 'N/A') + '</dd> \
                              <dt class="col-sm-3">Speciality</dt> \
                              <dd class="col-sm-9">' + res.speciality + '</dd> \
                            </dl> \
                          </div>';
          $("#div-physician").append(physician);
          
        },
        error: function(res){
          alert(res);
        }
      })

      if($("#appointment_schedule_day").val() != ""){
        check();
      }

      $("#div-physician").show();
      $("#div-schedule").show();
    }
    else {
      $("#div-physician").hide();
      $("#div-schedule").hide();
    }
  })

  $("#appointment_schedule_day").on("change", function(){
    var physician_id = $("#appointment_physician_id").val();

    if(this.value != ""){
      check();

      $("#appointment_schedule_time").show();
    }
    else {
      $("#appointment_schedule_time").hide();
    }
  })
})
