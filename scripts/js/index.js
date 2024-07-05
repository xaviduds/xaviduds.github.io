// let sortDirection = { name: null };
// let filters = [];
// let currentSearchText = '';
// let includeMode = true;
// let activeTags = [];

// function createProjectCard(project) {
//   const card = document.createElement('div');
//   card.className = 'project-card';
//   card.appendChild(createElement('h2', project.name, project.showcasePath));
//   card.appendChild(createElement('p', project.summary));
//   card.appendChild(createElement('p', `${project.tags.join(' ')}`));
//   return card;
// }

// function createElement(tag, text, href) {
//   const element = document.createElement(tag);
//   if (href) {
//     const link = document.createElement('a');
//     link.textContent = text;
//     link.href = href;
//     element.appendChild(link);
//   } else {
//     element.textContent = text;
//   }
//   return element;
// }

// function renderProjects() {
//   let filteredProjects = projects.filter(project => {
//     const matchesSearch = project.name.toLowerCase().includes(currentSearchText) || project.summary.toLowerCase().includes(currentSearchText);
//     const matchesTags = includeMode ? project.tags.some(tag => activeTags.includes(tag)) : activeTags.every(tag => project.tags.includes(tag));
//     return matchesSearch && (activeTags.length === 0 || matchesTags);
//   });

//   if (sortDirection.name) {
//     filteredProjects.sort((a, b) => sortDirection.name === 'asc' ? a.name.localeCompare(b.name) : b.name.localeCompare(a.name));
//   } 

//   const container = document.getElementById('projects-container');
//   container.innerHTML = '';
//   filteredProjects.forEach(project => container.appendChild(createProjectCard(project)));
// }

// function populateTags() {
//   const tagsBar = document.getElementById('tags-bar');
//   tagsBar.innerHTML = '';
//   const allTags = [...new Set([...predefinedTags, ...projects.flatMap(project => project.tags)])]; // Combine and deduplicate tags
//   ['All', ...allTags].forEach(tag => {
//     tagsBar.appendChild(createTagButton(tag));
//   });
// }

// function addFilter() {
//   const mode = document.querySelector('input[name="filter-mode"]:checked').value;
//   const type = document.getElementById('filter-type').value;
//   const value = document.getElementById('filter-value').value.toLowerCase();

//   filters.push({ mode, type, value });
//   renderActiveFilters();
//   filterProjects();
// }

// function renderActiveFilters() {
//   const activeFiltersDiv = document.getElementById('active-filters');
//   activeFiltersDiv.innerHTML = ''; // Clear existing filters

//   filters.forEach((filter, index) => {
//     const filterDiv = document.createElement('div');
//     filterDiv.textContent = `${filter.mode.toUpperCase()}: ${filter.type} - ${filter.value}`;
//     const removeButton = document.createElement('button');
//     removeButton.textContent = 'Remove';
//     removeButton.onclick = () => {
//       filters.splice(index, 1);
//       renderActiveFilters();
//       filterProjects();
//     };
//     filterDiv.appendChild(removeButton);
//     activeFiltersDiv.appendChild(filterDiv);
//   });
// }

// function filterProjects() {
//   let filteredProjects = projects;

//   filters.forEach(filter => {
//     const projectFilter = project => project[filter.type].toLowerCase().includes(filter.value);
//     filteredProjects = filteredProjects.filter(filter.mode === 'include' ? projectFilter : p => !projectFilter(p));
//   });

//   renderProjects(filteredProjects);
// }

// document.getElementById('add-filter').addEventListener('click', () => {
//   const newFilter = createFilter();
//   if (!isContradictory(newFilter)) {
//     filters.push(newFilter);
//     renderActiveFilters();
//     filterProjects();
//   }
// });

// function createTagButton(tag) {
//   const tagElement = document.createElement('button');
//   tagElement.textContent = tag;
//   tagElement.className = 'tag-button';
//   tagElement.onclick = () => toggleTag(tag);
//   return tagElement;
// }

// function toggleTag(tag) {
//   const tagIndex = activeTags.indexOf(tag);
//   if (tag === 'All') {
//     activeTags = [];
//   } else {
//     tagIndex > -1 ? activeTags.splice(tagIndex, 1) : activeTags.push(tag);
//   }
//   updateTagButtons();
//   filterProjectsByTags();
// }

// function updateTagButtons() {
//   document.querySelectorAll('.tag-button').forEach(button => {
//     button.classList.toggle('active-tag', activeTags.includes(button.textContent));
//   });
// }

// function filterProjectsByTags() {
//   let filteredProjects = activeTags.length ? projects.filter(project => activeTags.every(tag => project.tags.includes(tag))) : projects;
//   renderProjects(filteredProjects);
// }

// function isContradictory(newFilter) {
//   return filters.some(filter => filter.type === newFilter.type && filter.mode !== newFilter.mode && filter.value === newFilter.value);
// }

// function createFilter() {
//   const mode = document.querySelector('input[name="filter-mode"]:checked').value;
//   const type = document.getElementById('filter-type').value;
//   const value = document.getElementById('filter-value').value.toLowerCase();
//   return { mode, type, value };
// }

// function sortProjects(criteria) {
//   const sortedProjects = [...projects];
//   const direction = sortDirection[criteria] === 'asc' ? 'desc' : 'asc';
//   sortDirection[criteria] = direction;
//   updateSortIndicators(criteria, direction);

//   if (criteria === 'name') {
//     sortedProjects.sort((a, b) => direction === 'asc' ? a.name.localeCompare(b.name) : b.name.localeCompare(a.name));
//   } 
//   renderProjects(sortedProjects);
// }

// function updateSortIndicators(criteria, direction) {
//   document.querySelectorAll('.sort-indicator').forEach(indicator => {
//     indicator.textContent = indicator.id === criteria ? (direction === 'asc' ? '↑' : '↓') : '';
//   });
// }

// function toggleIncludeMode() {
//   includeMode = !includeMode;
//   document.getElementById('include-mode-toggle').textContent = includeMode ? 'Inclusionary Search' : 'Exclusionary Search';
//   renderProjects();
// }

// document.addEventListener('DOMContentLoaded', () => {
//   // populateTags();
//   renderProjects();
//   document.getElementById('sort-name').addEventListener('click', () => sortProjects('name'));
//   // document.getElementById('include-mode-toggle').addEventListener('click', toggleIncludeMode);
//   // document.getElementById('search-title-toggle').addEventListener('click', toggleSearchTitles);
// });

