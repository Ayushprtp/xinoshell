import { FiCopy, FiTrash2, FiSearch, FiCalendar, FiX, FiChevronDown } from 'react-icons/fi';
import { motion } from 'framer-motion';
import { useState, useEffect } from 'react';

interface Message {
  id: string;
  timestamp: Date;
  sender: string;
  textMessage: string;
  type: string;
  deviceId: string;
  userId: string;
}

interface MessagesSectionProps {
  messages: Message[];
  searchTerm: string;
  setSearchTerm: (term: string) => void;
  sortOrder: string;
  setSortOrder: (order: string) => void;
  filterDate: string;
  setFilterDate: (date: string) => void;
  deleteMessage: (id: string) => void;
  copyToClipboard: (text: string) => void;
  isLoading: boolean;
}

export default function MessagesSection({
  messages,
  searchTerm,
  setSearchTerm,
  sortOrder,
  setSortOrder,
  filterDate,
  setFilterDate,
  deleteMessage,
  copyToClipboard,
  isLoading
}: MessagesSectionProps) {
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);
  
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentMessages = messages.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(messages.length / itemsPerPage);

  useEffect(() => {
    setCurrentPage(1);
  }, [searchTerm, sortOrder, filterDate]);

  const handlePrevPage = () => setCurrentPage(prev => Math.max(prev - 1, 1));
  const handleNextPage = () => setCurrentPage(prev => Math.min(prev + 1, totalPages));

  return (
    <div className="lg:col-span-2 bg-gray-800/50 rounded-xl shadow-lg p-6 border border-gray-700 backdrop-blur-sm flex flex-col" style={{ height: '150vh' }}>
      {/* Header and search controls */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
        <h2 className="text-xl font-bold text-white">Device Messages</h2>
        
        <div className="flex flex-col sm:flex-row gap-3 w-full sm:w-auto">
          <div className="relative flex-grow sm:w-64">
            <FiSearch className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              placeholder="Search messages..."
              className="w-full bg-gray-700/50 border border-gray-600 rounded-md pl-10 pr-4 py-2 text-white placeholder-gray-400 focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          
          <div className="flex gap-2">
            <select
              className="bg-gray-700/50 border border-gray-600 rounded-md px-3 py-2 text-white text-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
              value={sortOrder}
              onChange={(e) => setSortOrder(e.target.value)}
            >
              <option value="recent">Recent First</option>
              <option value="oldest">Oldest First</option>
            </select>
            
            <div className="relative">
              <input
                type="date"
                className="bg-gray-700/50 border border-gray-600 rounded-md px-3 py-2 text-white text-sm pr-8 focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                value={filterDate}
                onChange={(e) => setFilterDate(e.target.value)}
              />
              {filterDate && (
                <button
                  onClick={() => setFilterDate('')}
                  className="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-white"
                >
                  <FiX size={16} />
                </button>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Scrollable message list with fixed height */}
      <div className="overflow-y-auto flex-1 mb-4 pr-4 h-{100vh}">
        {isLoading ? (
          <div className="flex flex-col items-center justify-center h-full">
            <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500 mb-4"></div>
            <p className="text-gray-400">Loading messages...</p>
          </div>
        ) : currentMessages.length > 0 ? (
          <div className="space-y-1">
            {currentMessages.map((msg, index) => (
              <motion.div
                key={msg.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.2 }}
                className={`p-4 rounded-lg ${msg.type === 'incoming' ? 'bg-gray-700/30' : 'bg-indigo-900/20'} border ${msg.type === 'incoming' ? 'border-gray-600' : 'border-indigo-700'} hover:shadow-lg transition-all`}
              >
                <div className="flex justify-between items-start mb-2">
                  <div className="flex items-center gap-3">
                    <span className="text-xs px-2 py-1 rounded-full bg-gray-700/50 text-gray-300">
                      #{indexOfFirstItem + index + 1}
                    </span>
                    <span className={`text-sm font-medium ${msg.type === 'incoming' ? 'text-blue-400' : 'text-indigo-400'}`}>
                      {msg.sender}
                    </span>
                  </div>
                  <span className="text-xs text-gray-400">
                    {msg.timestamp.toLocaleString()}
                  </span>
                </div>
                <p className="text-white mb-3">{msg.textMessage}</p>
                <div className="flex justify-end gap-2">
                  <button
                    onClick={() => copyToClipboard(msg.textMessage)}
                    className="text-gray-400 hover:text-white p-1 rounded hover:bg-gray-600 transition-colors"
                    title="Copy"
                  >
                    <FiCopy size={16} />
                  </button>
                  <button
                    onClick={() => deleteMessage(msg.id)}
                    className="text-gray-400 hover:text-red-400 p-1 rounded hover:bg-gray-600 transition-colors"
                    title="Delete"
                  >
                    <FiTrash2 size={16} />
                  </button>
                </div>
              </motion.div>
            ))}
          </div>
        ) : (
          <div className="flex flex-col items-center justify-center h-full text-gray-400">
            <FiSearch size={48} className="mb-4 opacity-50" />
            <p className="text-lg">No messages found</p>
            <p className="text-sm mt-1">Try adjusting your search or filters</p>
          </div>
        )}
      </div>

      {/* Fixed pagination at bottom - Only show when not loading */}
      {!isLoading && messages.length > itemsPerPage && (
        <div className="flex justify-between items-center px-1 pt-4 border-t border-gray-700">
          <button
            onClick={handlePrevPage}
            disabled={currentPage === 1}
            className={`flex items-center gap-1 px-3 py-1 rounded-md ${currentPage === 1 ? 'text-gray-500 cursor-not-allowed' : 'text-indigo-400 hover:bg-indigo-900/30'}`}
          >
            <FiChevronDown className="transform rotate-90" />
            Previous
          </button>
          
          <div className="flex gap-1">
            {Array.from({ length: Math.min(5, totalPages) }).map((_, i) => {
              let pageNum;
              if (totalPages <= 5) {
                pageNum = i + 1;
              } else if (currentPage <= 3) {
                pageNum = i + 1;
              } else if (currentPage >= totalPages - 2) {
                pageNum = totalPages - 4 + i;
              } else {
                pageNum = currentPage - 2 + i;
              }
              
              return (
                <button
                  key={pageNum}
                  onClick={() => setCurrentPage(pageNum)}
                  className={`w-8 h-8 rounded-full flex items-center justify-center ${currentPage === pageNum ? 'bg-indigo-600 text-white' : 'text-gray-300 hover:bg-gray-700'}`}
                >
                  {pageNum}
                </button>
              );
            })}
          </div>
          
          <button
            onClick={handleNextPage}
            disabled={currentPage === totalPages}
            className={`flex items-center gap-1 px-3 py-1 rounded-md ${currentPage === totalPages ? 'text-gray-500 cursor-not-allowed' : 'text-indigo-400 hover:bg-indigo-900/30'}`}
          >
            Next
            <FiChevronDown className="transform -rotate-90" />
          </button>
        </div>
      )}
    </div>
  );
}