window.addEventListener("load", (event) => {
  document.getElementById("appointment_patient_id").addEventListener("change", function(){
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
          alert("Success " + res);
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

  document.getElementById("appointment_physician_id").addEventListener("change", function(){
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
          alert(res);
        },
        error: function(res){
          alert(res);
        }
      })

      $("#div-physician").show();
    }
    else {
      $("#div-physician").hide();
    }
  })

  document.getElementById("appointment_schedule").addEventListener("change", function(){
    var physician_id = $("#appointment_physician_id").val();
    var date = $("#appointment_schedule").val();
  
    $.ajax({
      url: "/check",
      type: "GET",
      dataType: "json",
      data: {
        physician_id: physician_id,
        date: date,
      },
      success: function(res){
        console.log(res)
      },
      error: function(res){
        alert("Something happened" + res);
      }
    })
  })
})
