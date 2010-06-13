# require 'couchrest'
# 
# def setup_views
#   jobs_all_published
#   jobs_all_un_published
# end
# 
# def jobs_all_published
#   db = CouchRest.database!("https://kedgedsomentrabledscalmo:tsIedY1winfFMEMOBE3gJHdC@cre8ivethought.cloudant.com:5984/fw4test")
# 
#   begin
#     db.delete_doc(db.get('_design/all_jobs'));
#   rescue Exception => e
#     
#   end
# 
#   db.save_doc({
#     "_id" => "_design/all_jobs", 
#     :views => {
#       :all => {
#         :map => '
#           function(doc) {
#             if (doc.type == "job" && doc.published) { 
#               emit(doc.publishDate, {
#                 id: doc._id, 
#                 rev: doc._rev, 
#                 title: doc.title, 
#                 subTitle: doc.subTitle, 
#                 text: doc.text,
#                 publishDate: doc.publishDate
#               }); 
#             }
#           }'
#         }
#       }
#     });
# end
# 
# def jobs_all_un_published
#   db = CouchRest.database!("https://kedgedsomentrabledscalmo:tsIedY1winfFMEMOBE3gJHdC@cre8ivethought.cloudant.com:5984/fw4test")
# 
#   begin
#     db.delete_doc(db.get('_design/draft_jobs'));
#   rescue Exception => e
#     
#   end
#   
#   db.save_doc({
#     "_id" => "_design/draft_jobs", 
#     :views => {
#       :all => {
#         :map => '
#           function(doc) {
#             if (doc.type == "job" && !doc.published) { 
#               emit(doc.publishDate, {
#                 id: doc._id, 
#                 rev: doc._rev, 
#                 title: doc.title, 
#                 subTitle: doc.subTitle, 
#                 text: doc.text,
#                 publishDate: doc.publishDate
#               }); 
#             }
#           }'
#         }
#       }
#     });
# end
