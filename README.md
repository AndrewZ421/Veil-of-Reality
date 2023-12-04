# Veil-of-Reality

Welcome to "Veil of Reality", a world brimming with endless possibilities. Here, players will traverse the full arc of life, from cradle to grave. You'll intimately experience the nuances of friendships, romances, setbacks, victories, sorrows, and joys.

## Group Members
- Xin Liu
- Yi Qu
- Caroline Zeng
- Andrew Zhao

## Description
Every individual you meet, every emotional touchpoint, and even every serendipitous coincidence is meticulously crafted for you by a sophisticated AI. Yet, you remain oblivious to this orchestration — for you, this is your authentic life journey. In "Veil of Reality", each decision and choice is met with real-time AI responses, crafting a unique and unpredictable life narrative for you. As you immerse yourself, you're compelled to ponder: What is real? What is preordained? In this unparalleled life simulation game, the lines between reality and fabrication have never been so blurred.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- **MySQL**: A relational database management system.
- **Flask**: A micro web framework written in Python.
- **Faker**: A Python package to generate fake data.
- **Hugging Face**: Libraries for advanced Natural Language Processing and Machine Learning. 

> **Note**: The backend system requires approximately 20 seconds to start as the Large Language Models (LLM) require this time to initialize.

## Backend Setup
To get the backend up and running, follow these steps:

1. **Install Flask and Related Packages**: Make sure you have Flask and other required packages installed. You can install them using pip:
   ```bash
   pip install flask flask_sqlalchemy ...
   ```

2. **Configure Database URI**: In `init.py`, update the database URI to point to your local MySQL instance.

3. **Load Initial Data**: Run `load_csv_to_db.py` to populate your database with initial data:
   ```bash
   python load_csv_to_db.py
   ```

4. **Start the Backend**: Finally, start your Flask application:
   ```bash
   flask run
   ```

   The backend should now be running and can be accessed via the specified port.

## Contributing to Veil-of-Reality
To contribute to Veil-of-Reality, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin <project_name>/<location>`
5. Create the pull request.

Alternatively, see the GitHub documentation on [creating a pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Contact
If you want to contact us, you can reach us at [943926227@qq.com].

---

This structure provides a comprehensive overview of your project, including setup instructions and how to contribute. Feel free to adjust the content to better fit your project's needs.
