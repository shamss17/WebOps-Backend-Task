class DeleteOldPostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    return unless post

    post.destroy if post.created_at <= 24.hours.ago
  end
end

