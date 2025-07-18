# StudyMgmt - Next-Generation Study Management System

A comprehensive prototype for preclinical study management with modern web technologies.

## 🏗️ Overview

StudyMgmt is a next-generation study management platform designed to manage preclinical study projects, supporting Protocol Authoring, Data Analysis, and Report Generation. The system offers high performance for large datasets and many users, with an elegant, modern, and intuitive UI/UX.

## ✨ Features

### 🏠 Dashboard
- **Usage Analytics**: Visualize system usage statistics, user activity, and report generations
- **Recent Activities & Logs**: Track user activities with filtering and search capabilities
- **Custom Widgets**: User-customizable dashboard layout with pluggable widgets
- **Top Studies & Users**: Highlight most active studies and users

### 📊 Report Generation
- **Project Selection & Data Filtering**: Advanced filtering by animal, group, date, and custom fields
- **Hupharm Parameter Adjustment**: Configure analysis parameters with preset management
- **Visualization Creation**: Generate customizable charts and tables with real-time preview
- **Report Template Selection**: Choose from templates with inline preview capabilities
- **Export & Versioning**: Export to Word format with version control and history tracking

### 📋 Protocol Builder
- **Protocol Authoring & Editing**: Modular chapter/section system with drag-and-drop editing
- **Versioning & Collaboration**: Real-time collaboration with comments and change tracking
- **Approval Workflow**: Configurable multi-step approval processes
- **Rich Text Editor**: Professional editing interface with formatting tools

### ❓ Help Center
- **Comprehensive Documentation**: Structured help articles with search functionality
- **Video Tutorials**: Step-by-step video guides with playback controls
- **Contextual Help**: Inline help and tooltips throughout the application
- **FAQ System**: Expandable frequently asked questions with search

### ⚙️ Administration
- **User & Permission Management**: Role-based access control with fine-grained permissions
- **Data Integration & Sync**: External system integrations (LIMS, ELN, Cloud Storage)
- **System Settings**: Configurable system-wide settings and preferences
- **Audit Logs**: Comprehensive activity logging with filtering and export capabilities

## 🛠️ Technology Stack

- **Frontend**: HTML5, Tailwind CSS, JavaScript (ES6+)
- **Charts**: Chart.js for data visualizations
- **Icons**: Font Awesome for consistent iconography
- **Interactions**: SortableJS for drag-and-drop functionality
- **Design**: CrownBio branding with modern UI/UX principles

## 📁 Project Structure

```
StudyMgmt/
├── Prototype/
│   ├── index.html              # Dashboard - Main landing page
│   ├── reports.html            # Report Generation module
│   ├── protocols.html          # Protocol Builder module
│   ├── help.html              # Help Center module
│   ├── admin.html             # Administration module
│   ├── study-list.html        # Study management
│   ├── assets/
│   │   └── js/
│   │       └── common.js      # Shared JavaScript functionality
│   ├── data-source-forms.js   # Data source configuration
│   ├── PROJECT_SUMMARY.md     # Detailed project documentation
│   └── README.md              # Prototype-specific documentation
└── README.md                  # This file
```

## 🚀 Getting Started

1. **Open the Application**
   ```bash
   # Navigate to the prototype directory
   cd Prototype
   
   # Open index.html in your web browser
   open index.html
   ```

2. **Navigation**
   - Use the sidebar menu to switch between different modules
   - Each module is a separate HTML file with its own functionality
   - The navigation header remains consistent across all pages

3. **Features to Explore**
   - **Dashboard**: View system analytics and recent activities
   - **Reports**: Create and export study reports with visualizations
   - **Protocols**: Build and collaborate on study protocols
   - **Help**: Access documentation and tutorials
   - **Admin**: Manage users, integrations, and system settings

## 🎨 Key Design Features

### Modern UI/UX
- **CrownBio Branding**: Custom CSS variables for consistent branding
- **Gradient Backgrounds**: Purple-to-blue gradients for visual appeal
- **Card-based Layout**: Clean, organized information presentation
- **Interactive Elements**: Hover effects and smooth transitions
- **Responsive Design**: Works on desktop and tablet devices

### Interactive Components
- **Real-time Charts**: Dynamic data visualizations using Chart.js
- **Drag-and-Drop**: Sortable sections in Protocol Builder
- **Toggle Switches**: Modern on/off controls for settings
- **Modal-like Previews**: In-place preview functionality

## 🔧 Development

### Browser Compatibility
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

### Code Quality
- Semantic HTML5 structure
- Modern CSS with Tailwind utility classes
- Clean, readable JavaScript with ES6+ features
- Consistent naming conventions and organization

## 🚀 Future Enhancements

- **Backend Integration**: Connect to real APIs and databases
- **Authentication**: Implement proper user authentication system
- **Real-time Collaboration**: WebSocket-based real-time features
- **Mobile App**: Native mobile application development
- **Advanced Analytics**: Machine learning-powered insights
- **Plugin System**: Extensible plugin architecture

## 📚 Documentation

For detailed information about the system architecture, features, and implementation, see:
- `Prototype/README.md` - Prototype-specific documentation
- `Prototype/PROJECT_SUMMARY.md` - Comprehensive project analysis

## 🤝 Support

This prototype demonstrates the complete user interface and interaction patterns for the StudyMgmt system. Each module provides a realistic representation of functionality that can be directly implemented in the development phase.

## 📄 License

This project is developed for CrownBio and is proprietary software for internal use.

---

**Note**: This is a high-fidelity prototype designed for demonstration and development reference. All data shown is simulated for illustration purposes. 