if @user.profile_type == 'Candidate'
  json.user do
    json.email @user.email
    json.name @user.profile.name
    json.image @user.profile.image_url
    json.generalInfo @user
    json.jobsApplied @user.profile.jobs_applied
  end

  if @user.curriculum
    json.curriculum do
      json.header @user.curriculum
      json.pastJobs @user.curriculum.jobs
      json.address @user.curriculum.candidate_address
      json.personal @user.curriculum.candidate_personal
    end

    json.interviews do
      json.array! @user.profile.interviews do |x|
        json.id x.id
        json.candidate_id x.candidate_id
        json.company_id x.company_id
        json.job_offer_id x.job_offer_id
        json.status x.status
        json.company x.company
        json.candidate x.candidate
        json.job_offer x.job_offer
      end
    end

  end

end

if @user.profile_type == 'Company'
  json.user do
    json.name @user.profile.name
    json.image @user.profile.image_url
    json.generalInfo @user
  end
  json.companyInfo do
    json.header @user.profile.header
    json.jobOffers do
      json.array! @user.job_offers do |j|
        json.candidates do
          json.array! j.candidates do |c|
            json.user do
              json.curriculum do
                json.candidate_address c.user.curriculum.candidate_address
                json.candidate_personal c.user.curriculum.candidate_personal
                json.id c.user.curriculum.id
                json.user_id c.user.curriculum.user.id
                json.about_me c.user.curriculum.about_me
              end
              json.id c.user.id
              json.email c.user.email
            end
            json.name c.name
            json.id c.id
            json.image_url c.image_url
          end
        end
        json.approved j.approved
        json.id j.id
        json.requirement j.requirement
        json.user_id @user.id
        json.salary j.salary
        json.position j.position
      end
    end

    json.address @user.profile.company_address
    json.personal @user.profile.company_personal
  end
  json.interviews do
    json.array! @user.profile.interviews do |i|
      json.company i.company
      json.candidate i.candidate
      json.job_offer i.job_offer
    end
  end
end
