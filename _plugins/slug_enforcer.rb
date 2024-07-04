module Reading
    class Generator < Jekyll::Generator
        def generate(site)
            # site.posts.docs.each do |post|
            #     puts post.data
            #     unless post.data.key?("slug")
            #         raise "Post '#{post.path}' does not have slug. Please add"
            #     end
            # end
        end
    end
end