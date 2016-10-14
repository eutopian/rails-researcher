$(function() {
  submitForm()
});

function CommentReplyId(dataid) {
  this.data-id = data-id
}

function submitForm() {
  $('form').submit(function(e) {
    var rName = $('#').val()
    var rOwner = $('#repoOwner').val()
    var title = $('#title').val()
    var body = $('#body').val()
    e.preventDefault();
    createIssue(rName, rOwner, title, body)
  })
}

function createIssue(rName, rOwner, title, body) {
    var uri = "https://api.github.com/repos/" + rOwner + "/" + rName + "/issues"
  $.ajax({
    url: uri, 
    type: "POST",
    headers: {
      Authorization: "token "+this.token
    },
    data: JSON.stringify({
      title: title, 
      body: body
    }), 
    success: function(data) {
      handleResponse(data)
    },
    error: function(error) {
      handleError()
    }
  })
}

function Issue(issueURL, title, body){
  this.issueURL = issueURL;
  this.title = title;
  this.body = body;
}

Issue.prototype.renderIssue = function(selector) {
  var link = $('<a>')
  .attr('href', this.issueURL)
  .text(this.title);
    selector.append(link);
}

function handleResponse(data) {
  var issue = new Issue(data.html_url, data.title, data.body)
  issue.renderIssue($("#issue"))
}

function handleError(jqXHR, textStatus, error) {
  console.log("Post error: " + error);
}