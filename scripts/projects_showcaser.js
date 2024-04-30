import {projects} from './projects.js';

const predefinedTags = [
 'ML', 
 'App',
 'Python', 
 'SQL',
 'Rust',
 'Nix',
 'Linux',
];

let activeTags = [];
let sortDirection = { name: null, date: null };
let currentSearchText = '';
let includeMode = false;
let searchTitlesOnly = false;

function createProjectCard(project) {
  const card = document.createElement('div');
  card.className = 'project-card';
  card.appendChild(createElement('h2', project.name, project.showcasePath));
  card.appendChild(createElement('p', project.summary));
  card.appendChild(createElement('p', `${project.tags.join(' ')}`));
  card.appendChild(createElement('p', `Last Modified: ${project.modifiedDate}`));
  return card;
}

function createElement(tag, text, href) {
  const element = document.createElement(tag);
  if (href) {
    const link = document.createElement('a');
    link.textContent = text;
    link.href = href;
    element.appendChild(link);
  } else {
    element.textContent = text;
  }
  return element;
}

function renderProjects() {
  let filteredProjects = projects.filter(project => {
    const matchesSearch = project.name.toLowerCase().includes(currentSearchText) || project.summary.toLowerCase().includes(currentSearchText);
    const matchesTags = includeMode ? project.tags.some(tag => activeTags.includes(tag)) : activeTags.every(tag => project.tags.includes(tag));
    return matchesSearch && (activeTags.length === 0 || matchesTags);
  });

  if (sortDirection.name) {
    filteredProjects.sort((a, b) => sortDirection.name === 'asc' ? a.name.localeCompare(b.name) : b.name.localeCompare(a.name));
  } else if (sortDirection.date) {
    filteredProjects.sort((a, b) => sortDirection.date === 'asc' ? new Date(a.modifiedDate) - new Date(b.modifiedDate) : new Date(b.modifiedDate) - new Date(a.modifiedDate));
  }

  const container = document.getElementById('projects-container');
  container.innerHTML = '';
  filteredProjects.forEach(project => container.appendChild(createProjectCard(project)));
}

function populateTags() {
  const tagsBar = document.getElementById('tags-bar');
  tagsBar.innerHTML = '';
  const allTags = [...new Set([...predefinedTags, ...projects.flatMap(project => project.tags)])]; // Combine and deduplicate tags
  ['All', ...allTags].forEach(tag => {
    tagsBar.appendChild(createTagButton(tag));
  });
}

function toggleSearchTitles() {
  searchTitlesOnly = !searchTitlesOnly;
  document.getElementById('search-title-toggle').textContent = searchTitlesOnly ? 'Search Titles Only' : 'Search Titles/Summaries';
  filterProjects();
}

function filterProjects() {
  const searchBar = document.getElementById('search-bar');
  const searchText = searchBar.value.toLowerCase();
  const filteredProjects = projects.filter(project => {
    const searchInTitle = project.name.toLowerCase().includes(searchText);
    const searchInSummary = project.summary.toLowerCase().includes(searchText);
    return searchTitlesOnly ? searchInTitle : searchInTitle || searchInSummary;
  });
  renderProjects(filteredProjects);
}

function createTagButton(tag) {
  const tagElement = document.createElement('button');
  tagElement.textContent = tag;
  tagElement.classList.add('tag-button');
  tagElement.onclick = () => toggleTag(tag, tagElement);
  return tagElement;
}

function toggleTag(tag, tagElement) {
  if (tag === 'All') {
    activeTags = [];
    document.querySelectorAll('.tag-button').forEach(button => button.classList.remove('active-tag'));
    tagElement.classList.add('active-tag');
  } else {
    if (activeTags.includes(tag)) {
      activeTags = activeTags.filter(t => t !== tag);
      tagElement.classList.remove('active-tag');
    } else {
      activeTags.push(tag);
      tagElement.classList.add('active-tag');
      document.querySelector('.tag-button').classList.remove('active-tag'); // 'All' tag
    }
  }
  filterProjectsByTags();
}

function filterProjectsByTags() {
  let filteredProjects = activeTags.length > 0 ? projects.filter(project => activeTags.every(tag => project.tags.includes(tag))) : projects;
  renderProjects(filteredProjects);
}

function sortProjects(criteria) {
  const sortedProjects = [...projects];
  const direction = sortDirection[criteria] === 'asc' ? 'desc' : 'asc';
  sortDirection[criteria] = direction;
  updateSortIndicators(criteria, direction);

  if (criteria === 'name') {
    sortedProjects.sort((a, b) => direction === 'asc' ? a.name.localeCompare(b.name) : b.name.localeCompare(a.name));
  } else if (criteria === 'date') {
    sortedProjects.sort((a, b) => direction === 'asc' ? new Date(a.modifiedDate) - new Date(b.modifiedDate) : new Date(b.modifiedDate) - new Date(a.modifiedDate));
  }
  renderProjects(sortedProjects);
}

function updateSortIndicators(criteria, direction) {
  document.querySelectorAll('.sort-indicator').forEach(indicator => {
    indicator.textContent = indicator.id === criteria ? (direction === 'asc' ? '↑' : '↓') : '';
  });
}

document.addEventListener('DOMContentLoaded', () => {
  populateTags();
  renderProjects();
  document.getElementById('sort-name').addEventListener('click', () => sortProjects('name'));
  document.getElementById('sort-date').addEventListener('click', () => sortProjects('date'));
  document.getElementById('include-mode-toggle').addEventListener('click', toggleIncludeMode);
  document.getElementById('search-title-toggle').addEventListener('click', toggleSearchTitles);
});

function toggleIncludeMode() {
  includeMode = !includeMode;
  document.getElementById('include-mode-toggle').textContent = includeMode ? 'Inclusionary Search' : 'Exclusionary Search';
  renderProjects();
}
