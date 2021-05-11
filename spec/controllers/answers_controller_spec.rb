require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #show' do
    let(:answer) { create(:answer, question: question) }

    before { get :show, params: { question_id: question, id: answer } }

    it 'assigns the requested question to @question' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question} }
    it 'assigns a new answer to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:answer) { create(:answer, question: question) }
    before { get :edit, params: { question_id: question, id: answer } }
    it 'assigns a requested answer to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new answer in DB' do
        expect { post :create, params: { answer: attributes_for(:answer) }}
      end
    end
    context 'with invalid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer) }}
      end

      it 're-renders new view' do
        create_request
      end
    end
  end
end
