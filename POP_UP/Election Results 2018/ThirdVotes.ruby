// Write a script to return a value to show in the pop-up.
// For example, get the average of 4 fields:
// Average($feature.SalesQ1, $feature.SalesQ2, $feature.SalesQ3, $feature.SalesQ4)

var electionArray = [{ 'PARTY': 'GRN', 'NAME': $feature["ElectionResults_csv_PVNBGPname"], 'VOTES': $feature["ElectionResults_csv_PVNBGPvotes"] },{ 'PARTY': 'IND', 'NAME': $feature["ElectionResults_csv_INDname"], 'VOTES': $feature["ElectionResults_csv_INDvotes"] },{ 'PARTY': 'KIS', 'NAME': $feature["ElectionResults_csv_KNBname"], 'VOTES': $feature["ElectionResults_csv_KNBvotes"] },{ 'PARTY': 'LIB', 'NAME': $feature["ElectionResults_csv_Lname"], 'VOTES': $feature["ElectionResults_csv_Lvotes"] },{ 'PARTY': 'NDP', 'NAME': $feature["ElectionResults_csv_NDPname"], 'VOTES': $feature["ElectionResults_csv_NDPvotes"] },{ 'PARTY': 'PA', 'NAME': $feature["ElectionResults_csv_PANBname"], 'VOTES': $feature["ElectionResults_csv_PANBvotes"] },{ 'PARTY': 'PC', 'NAME': $feature["ElectionResults_csv_PCname"], 'VOTES': $feature["ElectionResults_csv_PCvotes"] }]
function compareVotes(a,b){
if (a['VOTES']<b['VOTES'])
return -1;
if (a['VOTES']>b['VOTES'])
return 1;
return 0; }
var sortArray = Sort(electionArray, compareVotes);

var Dict = sortArray[4]

if (Dict.VOTES == 0) {
    var Party = null
    var Name = null
    var Votes = null
  }
  else {
    var Party = Dict.PARTY
    var Name = Dict.NAME
    var Votes = Dict.VOTES
  }

return Votes




