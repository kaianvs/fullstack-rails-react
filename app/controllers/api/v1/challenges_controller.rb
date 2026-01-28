module Api
  module V1
    class ChallengesController < ApplicationController
        before_action :set_challenge, only: %i[ show update destroy ]

      # GET /api/v1/challenges
      def index
        @challenges = Challenge.all
        render json: @challenges
      end

      # GET /api/v1/challenges/:id
      def show
        render json: { message: "Challenge found", data: @challenge }
      end

      # POST /api/v1/challenges
      def create
        @challenge = Challenge.new(challenge_params)

        if @challenge.save
          render json: { message: "Challenge created successfully", data: @challenge }
        else
          render json: { message: "Challenge not created", data: @challenge.errors }
        end
      end

      # PATCH/PUT /api/v1/challenges/:id
      def update
        if @challenge.update(challenge_params)
          render json: { message: "Challenge updated successfully", data: @challenge }
        else
          render json: { message: "Challenge not updated", data: @challenge.errors }
        end
      end

      # DELETE /api/v1/challenges/:id
      def destroy
        if @challenge.destroy
          render json: { message: "Challenge deleted successfully", data: @challenge }
        else
          render json: { message: "Challenge not deleted", data: @challenge.errors }
        end
      end

      private
      def set_challenge
        @challenge = Challenge.find(params[:id])
      end
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end
    end
  end
end
