/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
// ANY
// Traitement des poke dans le commentaire de la mise à jour.
// Vérifier si les logins saisis dans le commentaire existent dans la BD

function avoidIssueFormSubmit(myurl)
{   var forceSubmitForm = false;

    jQuery('#issue-form').submit(function(e) {
        if (forceSubmitForm) return true;
        var notes_text = jQuery("#notes").val();
        var results = notes_text.blank() ? [] : notes_text.match(/(poke @[\w+\.]*)/g);
        if (notes_text.blank() || results.length == 0) return true;
        if (results.length > 0 )
            {    var datas = "";
                 results.each(function(j) {datas += "logins[]=" + j.replace(/poke @/,"") + "&";});
                 jQuery.ajax({
                     url: myurl,
                     data: datas,
                     success: function() {if (jQuery("#force-submit-form").val() == "1") {forceSubmitForm = true; jQuery('#issue-form').submit();}}
                 });
            }
       e.preventDefault();
       return false;
    });
}



// Add a Poke icon
function addPokeIcon()
{var content = "<button id='poke_icon' class='jstb_slink' onclick='addPokeTag(\"notes\", \"poke @\");' type='button' tabindex='200' title='Poke' style='background-image: url(\"/plugin_assets/chiliproject_poke/images/poke.png\");'> <span>Poke</span> </button>"
  jQuery('fieldset .jstElements .jstt_smiles').before(content);
}


function addPokeTag(myFieldId, myValue, mySuffix){
  myField = document.getElementById(myFieldId);

  myField.focus();
  prefix = myValue || '';
  suffix = mySuffix || '';
  var start, end, sel, scrollPos, subst, res;
  if (typeof(document["selection"]) != "undefined") {
      sel = document.selection.createRange().text;
  } else if (typeof(myField["setSelectionRange"]) != "undefined") {
      start = myField.selectionStart;
      end = myField.selectionEnd;
      scrollPos = myField.scrollTop;
      sel = myField.value.substring(start, end);
  }
  if (sel.match(/ $/)) {
      sel = sel.substring(0, sel.length - 1);
      suffix = suffix + " ";
  }
  if (typeof(fn) == 'function') {
      res = (sel) ? fn.call(this, sel) : fn('');
  } else {
      res = (sel) ? sel : '';
  }
  subst = prefix + res + suffix;
  if (typeof(document["selection"]) != "undefined") {
      var range = document.selection.createRange().text = subst;
      myField.caretPos -= suffix.length;
  } else if (typeof(myField["setSelectionRange"]) != "undefined") {
      myField.value = myField.value.substring(0, start) + subst + myField.value.substring(end);
      if (sel) {
          myField.setSelectionRange(start + subst.length, start + subst.length);
      } else {
          myField.setSelectionRange(start + prefix.length, start + prefix.length);
      }
      myField.scrollTop = scrollPos;
  }
}
