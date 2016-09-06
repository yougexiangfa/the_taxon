require 'test_helper'

class NodeParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @node_parent = node_parents(:one)
  end

  test "should get index" do
    get node_parents_url
    assert_response :success
  end

  test "should get new" do
    get new_node_parent_url
    assert_response :success
  end

  test "should create node_parent" do
    assert_difference('NodeParent.count') do
      post node_parents_url, params: { node_parent: {  } }
    end

    assert_redirected_to node_parent_url(NodeParent.last)
  end

  test "should show node_parent" do
    get node_parent_url(@node_parent)
    assert_response :success
  end

  test "should get edit" do
    get edit_node_parent_url(@node_parent)
    assert_response :success
  end

  test "should update node_parent" do
    patch node_parent_url(@node_parent), params: { node_parent: {  } }
    assert_redirected_to node_parent_url(@node_parent)
  end

  test "should destroy node_parent" do
    assert_difference('NodeParent.count', -1) do
      delete node_parent_url(@node_parent)
    end

    assert_redirected_to node_parents_url
  end
end
