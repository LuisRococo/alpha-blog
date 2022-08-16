require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

    def setup
        @category = Category.new(name: "Fantasy")
    end

    test "category should be valid" do
        assert @category.valid?
    end

    test "name should be present" do
        @category.name = ""
        assert_not @category.valid?
    end

    test "name should be unique" do
        @category.save
        @category2 = Category.new(name: @category.name)
        assert_not @category2.valid?
    end

    test "name should not be too long" do
        name = "z" * 26
        @category.name = name
        assert_not @category.valid?
    end

    test "name should not be too short" do
        name = "z" * 2
        @category.name = name
        assert_not @category.valid?
    end

end
