require 'spec_helper'

describe User do
  let(:user) { User.create(email: 'bones@skellingtons.com', password: 'yogs')}

  it 'can be created' do
    expect(user).to_not be_nil
  end

  it 'has an email' do
    expect(user.email).to_not be_nil
  end

  it 'has an encrypted password' do
    expect(user.encrypted_password).to_not be_nil
  end

  it 'does not save the unencrypted password' do
    expect(User[user.id].password).to be_nil
  end

  it 'can be authenticated' do
    expect(User.authenticate(user.email, user.password)).to_not be_nil
  end

  it 'cannot be authenticated with bad credentials' do
    expect(User.authenticate(user.email, user.password)).to eq(false)
  end
end
