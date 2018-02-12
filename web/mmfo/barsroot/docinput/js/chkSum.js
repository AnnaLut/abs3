function isZero(v) { return v == undefined || v == null || v == "" || v == 0; }

var _operations = {
    "mul": function (operandA, operandB) { return operandA * operandB; },
    "div": function (operandA, operandB) { return operandA / operandB; }
};

function operation(operandA, operandB, fractionDigits, oper) {
    var res = 0;
    if (!isZero(operandB)) {
        res = new Number(_operations[oper](operandA, operandB));
    }
    return res.toFixed(fractionDigits);
}

function rigthMult(operandA, operandB){    return operation(operandA, operandB, 6, "mul");}
function rigthDiv(operandA, operandB){    return operation(operandA, operandB, 2, "div");}

function SumA_Blur()
{ 
  var elemA = GetValue("SumA");
  var elemB = GetValue("SumB");
  var elemR = GetValue("CrossRat");

  SetValue("SumB", rigthMult(elemA, elemR));
  if (document.getElementById("SumA").execFunc) {
      CalcPFC();
  }
}
function SumB_Blur()
{
  var elemA = GetValue("SumA");
  var elemB = GetValue("SumB");
  var elemR = GetValue("CrossRat");
  if (document.getElementById("__FLAGS").value.substring(59, 60) == "1") {
      if (elemA != 0 && !document.getElementById("CrossRat").readOnly) SetValue("CrossRat", elemB / elemA);
  } else if (document.getElementById("__FLAGS").value.substring(59, 60) == "3") {
      SetValue("SumB", rigthMult(elemA, elemR));
  }
  else {
      //if(document.getElementById("__DK").value == "0")
        SetValue("SumA", rigthDiv(elemB,elemR));
  }
  if(document.getElementById("reqv_KURS"))
		document.getElementById("reqv_KURS").value = GetValue("CrossRat");
}
function CRat_Blur()
{ 
  var elemA = GetValue("SumA");
  var elemB = GetValue("SumB");
  var elemR = GetValue("CrossRat");
  if (document.getElementById("__FLAGS").value.substring(59,60)=="1") {
	SetValue("SumB",rigthMult(elemA,elemR));
  }
  if(document.getElementById("reqv_KURS"))
		document.getElementById("reqv_KURS").value = GetValue("CrossRat");
} 
function SumC_Blur()
{
 var elemC = GetValue("SumC");
 var elemA = GetValue("SumA");
 SetValue("SumA",elemC);
 var elemB = GetValue("SumB");
 SetValue("SumB",elemC);
}
