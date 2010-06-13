# require 'couchrest'
# 
# def setup_data
#   ["C#", "F#", "VB.Net", "C++", "Ruby"].each do |job|
#     jobs(job)
#   end
# end
# 
# def jobs(job)
#   db = CouchRest.database!("https://kedgedsomentrabledscalmo:tsIedY1winfFMEMOBE3gJHdC@cre8ivethought.cloudant.com:5984/fw4test")
# 
#   db.save_doc({
#     :subTitle => job + " Developer - 9 Month Fixed-Term Contract \u2013 Up to £42,000 pro rata.",
#     :title => job + " Developer - Mansfield",
#     :text => "One of UK's leading organisations requires the expertise of a .NET Developer with proven commercial analysis skills for an initial 9 month fixed-term contract.\n\n \n\nYou will possess demonstrable experience in business problem solving and good software engineering principles, with exposure to all parts of the full software development life cycle.\n\n \n\nHaving the ability to work in either a small team or individually with sufficient self motivation you will show an excellent understanding of C#. An understanding of VB6 will be advantageous and any additional GUI design skills would also be useful.",
#     :sections => [{
#         :title => "Main duties:",
#         :text => "    * Develop new applications, using both WinForms and Web Clients.\n    * Assist in the creation and maintenance of the associated web sites, from Intranet to Internet.\n    * Communicating amendments and timescales to users and sponsors throughout the project lifecycle.\n    * Participation in team review and project management.\n    * Creating and maintaining records and documentation."
#       },{
#         :title => "Skills required:",
#         :text => "    * Good GUI development skills both thin and thick client.\n    * Understanding of good programming techniques.\n    * Good database object and interface design skills.\n    * Good user liaison and analytical skills.\n    * High level of general computer skills.\n    * Ability to work to deadlines and under pressure.\n    * Must work well in a team environment.\n    * Awareness of continuous integration, source control, and refactoring."
#       },{
#         :title => "Technical environment:",
#         :text => "    * Microsoft .NET Framework 2.0/3.5\n    * Microsoft Visual Studio 2005/2008, utilising C# and ASP.NET and WPF\n    * Microsoft SQL Server 2000 and 2005 moving towards 2008. This includes utilising Reporting Services\n    * NHibernate\n    * Microsoft Visual Basic 6, using ADO delivery methods for legacy support\n    * COM/COM+\n    * Microsoft VBScript\n    * Third Party Control Suites\n    * ODBC.\n    * Windows 2003 Server and XP Client\n    * Microsoft IIS\n    * Web browsers\n    * SourceGear Vault\n    * CruiseControl.NET\n    * XML, HTML, Microsoft ASP and JavaScript"
#       },{
#         :title => "Salary:",
#         :text => "Up to £42,000 Pro Rata + Benefits!"
#       },{
#         :title => "Location:",
#         :text => "Mansfield"
#       },{
#         :title => "[Cordius]",
#         :text => "Cordius is a recruitment business with over 20 years experience of the IT recruitment industry and we are confident we can help find your next career move. We recruit Permanent and Contract Development, Architect, Technical Team Lead, Senior Developer, Principal Software Engineer, Software Developer, Software Engineer, Analyst Programmer, Junior Developer, Junior Software Engineer, C#, .NET, ASP.NET, VB.NET, SQL Server jobs across the East Midlands and South Yorkshire.  Please feel free to browse our latest opportunities and may we wish you every success in your search for the 'ideal role'."
#       },{
#         :title => "Link:",
#         :text => "http://jobview.monster.co.uk/C-Developer-Mansfield-Job-Mansfield-Midlands-UK-87208588.aspx"
#     }],
#     :publishDate => Date.new.inspect.to_a,
#     :type => "job",
#     :published => true,
#     :location => {
#       :lat => 60.3880719,
#       :lon => 5.3318512,
#       :address => "Bergen railway station, Norway"
#     }
#   })
# end
