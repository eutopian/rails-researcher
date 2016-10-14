class CommentSerializer
  def self.serialize(comment)
    serialized_comment = '{'
    serialized_comment += '"id": ' + comment.id.to_s + ', '
    serialized_comment += '"content": "' + comment.content + '", '
    serialized_comment += '"commentable_type": "' + comment.commentable_type + '", '
    serialized_comment += 
    serialized_comment += '"user": {'
    serialized_comment += '"name": "' + comment.user.name + '"}' + ', '
    serialized_comment += '"commentable_type": {'
    serialized_comment += '"name": "' + article.topic.name + '"}'
    serialized_comment += '}'
  end
end