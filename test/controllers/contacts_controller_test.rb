require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  let(:contact) { create(:contact) }

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  describe "POST #create" do
    context "invalid params" do
      test "phone number is not an integer" do
        assert_no_difference('Contact.count') do
          post contacts_url, params: { contact: { name: 'name', phones_attributes: {'0': { number: 'number' } } } }
        end

        assert_equal assigns(:contact).errors.full_messages, ["Phones number is not a number"]
        assert_response :success
      end

      test "name is duplicated" do
        contact
        assert_no_difference('Contact.count') do
          post contacts_url, params: { contact: { name: contact.name, phones_attributes: {'0': { number: 1234 }, '1': { number: 1234 } } } }
        end

        assert_equal assigns(:contact).errors.full_messages, ["Name has already been taken"]
      end

      test "contact name is missing" do
        assert_no_difference('Contact.count') do
          post contacts_url, params: { contact: { name:'', phones_attributes: {'0': { number: 123456 } } } }
        end

        assert_equal assigns(:contact).errors.full_messages, ["Name can't be blank"]
      end
    end

    context "valid params" do
      test "should create contact" do
        assert_difference('Contact.count') do
          post contacts_url, params: { contact: { name:'name', phones_attributes: {'0': { number: 123456 } } } }
        end

        assert_redirected_to contact_url(Contact.last)
      end
    end
  end


  describe "GET #show" do
    test "should show contact" do
      get contact_url(contact)
      assert_response :success
    end
  end

  describe "GET #edit" do
    test "should get edit" do
      get edit_contact_url(contact)
      assert_response :success
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      test "should update contact" do
        patch contact_url(contact), params: { contact: { name: contact.name } }
        assert_redirected_to contact_url(contact)
      end
    end

    context "with invalid params" do
      test "should not update contact" do
        patch contact_url(contact), params: { contact: { name:'name', phones_attributes: {'0': { number: contact.phones.first.number } } } }

        assert_equal assigns(:contact).errors.full_messages, ["Phones number has already been taken"]
      end
    end
  end

  describe "DELETE #destroy" do
    test "should destroy contact" do
      contact
      assert_difference('Contact.count', -1) do
        delete contact_url(contact)
      end

      assert_redirected_to contacts_url
    end
  end
end
