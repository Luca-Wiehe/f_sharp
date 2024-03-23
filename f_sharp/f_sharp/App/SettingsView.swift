import SwiftUI

struct SettingsView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var darkModeIsOn: Bool = true
    @State private var soundSettingsIsOn: Bool = true
    @State private var privacySettingsIsOn: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.leading, 24)
                .padding(.top, 12)

            Form {
                // General Settings
                Section(header: Text("General")) {
                    Toggle("Dark Mode", isOn: $darkModeIsOn)
                    Picker("First Day of the Week", selection: .constant(1)) {
                        Text("Sunday").tag(1)
                        Text("Monday").tag(2)
                        // Add more days if needed
                    }
                    Toggle("Sound Settings", isOn: $soundSettingsIsOn)
                }
                
                // Account Settings
                Section(header: Text("Account")) {
                    TextField("Username", text: $username)
                    TextField("E-Mail", text: $email)
                    SecureField("Password", text: $password)
                }
                
                // Privacy Settings
                Section(header: Text("Privacy")) {
                    Text("Terms of Use")
                    Toggle("Privacy Settings", isOn: $privacySettingsIsOn)
                }
                
                // Support Settings
                Section(header: Text("Support")) {
                    Button("Contact Us") {
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 1)
    }
}
