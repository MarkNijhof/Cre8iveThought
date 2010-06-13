# require 'couchrest'
# 
# def clear_data
#   clear_all_jobs
#   clear_all_drafts
# end
# 
# def clear_all_jobs
#   db = CouchRest.database!("https://kedgedsomentrabledscalmo:tsIedY1winfFMEMOBE3gJHdC@cre8ivethought.cloudant.com:5984/fw4test")
#   db.view('all_jobs/all')['rows'].each do |row|
#     db.delete_doc(db.get(row["id"]));
#   end
# end
# 
# def clear_all_drafts
#   db = CouchRest.database!("https://kedgedsomentrabledscalmo:tsIedY1winfFMEMOBE3gJHdC@cre8ivethought.cloudant.com:5984/fw4test")
#   db.view('draft_jobs/all')['rows'].each do |row|
#     db.delete_doc(db.get(row["id"]));
#   end
# end
